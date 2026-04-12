#!/bin/bash
# SOSA™ Compliance Linter
# Usage: ./scripts/sosa-lint.sh /path/to/agent-or-plugin

set -e
TARGET="${1:-.}"
ERRORS=0
WARNINGS=0

echo "🔍 SOSA™ Compliance Lint — $(date)"
echo "Target: $TARGET"
echo "---"

# Pillar 1: Supervised — check for approval/escalation patterns
echo ""
echo "📋 Pillar 1: Supervised"
if grep -rq "approval\|escalat\|human.*confirm\|trust.*gradient" "$TARGET" 2>/dev/null; then
  echo "  ✅ Supervision patterns found"
else
  echo "  ⚠️  No supervision/approval patterns detected"
  WARNINGS=$((WARNINGS + 1))
fi

# Pillar 2: Orchestrated — check for bloated descriptions
echo ""
echo "📋 Pillar 2: Orchestrated"SKILL_FILES=$(find "$TARGET" -name "SKILL.md" -o -name "role-spec.*" -o -name "agent-spec.*" 2>/dev/null | wc -l)
if [ "$SKILL_FILES" -gt 0 ]; then
  echo "  ✅ Found $SKILL_FILES role spec file(s)"
else
  echo "  ❌ No role spec files found (SKILL.md, role-spec.*, agent-spec.*)"
  ERRORS=$((ERRORS + 1))
fi

for f in $(find "$TARGET" -name "SKILL.md" -o -name "*.md" 2>/dev/null); do
  WC=$(wc -w < "$f" 2>/dev/null || echo 0)
  if [ "$WC" -gt 3000 ]; then
    echo "  ⚠️  $f is $WC words (>3000) — consider trimming"
    WARNINGS=$((WARNINGS + 1))
  fi
done

# Pillar 3: Secured — check for hardcoded secrets
echo ""
echo "📋 Pillar 3: Secured"
if grep -rqE "(api[_-]?key|password|secret|token)\s*[:=]\s*['\"][^'\"]{8,}" "$TARGET" --include="*.py" --include="*.js" --include="*.ts" --include="*.json" --include="*.yml" --include="*.yaml" 2>/dev/null; then
  echo "  ❌ Potential hardcoded secrets detected!"
  ERRORS=$((ERRORS + 1))
else
  echo "  ✅ No hardcoded secrets found"
fi

# Pillar 4: Agents — check for formal agent definition
echo ""
echo "📋 Pillar 4: Agents"if grep -rq "tools\|tool.*manifest\|capability" "$TARGET" 2>/dev/null; then
  echo "  ✅ Tool/capability declarations found"
else
  echo "  ⚠️  No tool manifest or capability declarations detected"
  WARNINGS=$((WARNINGS + 1))
fi

# Summary
echo ""
echo "---"
echo "SOSA™ Lint Results:"
echo "  Errors:   $ERRORS"
echo "  Warnings: $WARNINGS"

if [ "$ERRORS" -gt 0 ]; then
  echo "  ❌ FAILED — fix errors before merging"
  exit 1
else
  echo "  ✅ PASSED"
  exit 0
fi
