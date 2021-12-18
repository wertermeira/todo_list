# Firstleaf Take Home Project

## instructions

### to start the application (step 1)
'docker-compose up'

### Populate TodoLists(require first step)

docker exec -it todolist_v1 bash -c 'bundle exec rails populate:todo_lists' \

### to run test (require first step)
docker exec -it firstleaf_test bash -c 'bundle exec rspec'


### Run application
http://localhost:3005




