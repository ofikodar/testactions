#----------------------------------------------
# go to dev branch
git config --global credential.helper cache
git checkout dev
#----------------------------------------------
# run tests
all_passed_code=0
cd ..
pytest -p no:cacheprovider
all_passed=`echo $?`
echo $all_passed
if [ $all_passed -gt $all_passed_code ]
then
  echo "Not All Passed"
  exit 1
fi
#----------------------------------------------
# if passed update staging branch
git config --global credential.helper cache
git checkout staging
git merge dev
git push origin staging
git checkout dev



