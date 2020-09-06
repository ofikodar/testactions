#----------------------------------------------
# update master branch
git config --global credential.helper cache
git checkout master
git merge dev
git push origin master

#----------------------------------------------
# create tag with timestamp
timestamp=$(date "+%Y%m%d%H%M")
git tag "$timestamp"
git push origin "$timestamp"

#----------------------------------------------
# delete the first tags
max_tags=5

all_tags=$(git tag --sort=-creatordate )
tags_counter=$(git tag | wc -l)
if [ "$tags_counter" -gt "$max_tags" ]
then
    need_to_delete=$((tags_counter - max_tags))
    delete_counter=0
    for git_tag in $all_tags
    do
      if [ "$need_to_delete" -gt "$delete_counter" ]
      then
        git push --delete origin $git_tag
        git tag -d $git_tag
      fi
      delete_counter=$((delete_counter + 1))
      done
fi