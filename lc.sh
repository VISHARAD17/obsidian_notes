#!/bin/bash
# Usage: ./lc.sh <problem-number>
# Example: ./lc.sh 1

NUM=$1
DIR=~/leetcode/$NUM
mkdir -p "$DIR"

MD="$DIR/problem.md"
JAVA="$DIR/Solution.java"

# Fetch problem slug from number
SLUG=$(curl -s "https://leetcode.com/api/problems/all/" \
  | python3 -c "
import sys, json
data = json.load(sys.stdin)
for p in data['stat_status_pairs']:
    if p['stat']['frontend_question_id'] == $NUM:
        print(p['stat']['question__title_slug'])
        break
")

if [ -z "$SLUG" ]; then
  echo "Problem $NUM not found"
  exit 1
fi

# Fetch problem details via GraphQL
RESPONSE=$(curl -s "https://leetcode.com/graphql" \
  -H "Content-Type: application/json" \
  --data "{\"query\":\"query { question(titleSlug: \\\"$SLUG\\\") { title difficulty content codeSnippets { lang code } } }\"}")

# Write markdown
python3 -c "
import sys, json, re
data = json.loads('''$RESPONSE''')
q = data['data']['question']
title = q['title']
difficulty = q['difficulty']
content = re.sub(r'<[^>]+>', '', q['content'])  # strip HTML tags
print(f'# {title}')
print(f'**Difficulty:** {difficulty}')
print()
print(content)
" > "$MD"

# Write Java starter
python3 -c "
import sys, json
data = json.loads('''$RESPONSE''')
snippets = data['data']['question']['codeSnippets']
for s in snippets:
    if s['lang'] == 'Java':
        print(s['code'])
        break
" > "$JAVA"

# Open in Neovim split
nvim -O "$MD" "$JAVA"
