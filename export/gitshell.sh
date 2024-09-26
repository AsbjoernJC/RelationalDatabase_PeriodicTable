mv element.sh ./periodic_table/element.sh
cd periodic_table
chmod +x element.sh
git init
sleep 1
git branch -m main
git add .
git commit -m "Initial commit"
touch removeme.sh
sleep 1
git add .
git commit -m "chore: 2nd commit"
rm removeme.sh
sleep 1
git add .
git commit -m "chore: 3rd commit"
touch removeme.sh
sleep 1
git add .
git commit -m "chore: 4th commit"
rm removeme.sh
sleep 1
git add .
git commit -m "chore: 5th commit"

$($PSQL "DELETE FROM properties WHERE atomic_number=1000")
$($PSQL "DELETE FROM elements WHERE atomic_number=1000")
$($PSQL "ALTER TABLE properties DROP COLUMN type")

git add .
git commit -m "feat: whizz khalifa"