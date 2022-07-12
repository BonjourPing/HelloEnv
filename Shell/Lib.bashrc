
function GitBranchName {
  #git symbolic-ref HEAD 2>/dev/null | cut -d"/" -f 3 -f 4
  local branch=$(git symbolic-ref --short HEAD 2>/dev/null)
  if [ ! $branch ]; then branch=$(git rev-parse --short HEAD 2>/dev/null); fi
  echo $branch
  #git rev-parse --abbrev-ref HEAD
}

function GitBranchPrompt {
    local branch=$(GitBranchName)
  if [ $branch ]; then printf "(git:%s)" $branch; fi
}
