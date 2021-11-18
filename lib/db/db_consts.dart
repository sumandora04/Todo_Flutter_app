const dDatabaseName = 'clear_todos.db';
const dTaskTable = 'task_table';
const dTaskId = 'id';
const dTaskTitle = 'title';
const dTaskIsDone = 'isTaskDone';

const dCollectionTable = 'collection_table';
const dCollectionId = 'colId';
const dCollectionTitle = 'title';

const createTaskTable =
    'CREATE TABLE $dTaskTable($dTaskId INTEGER PRIMARY KEY, $dCollectionId INTEGER, $dTaskTitle TEXT, $dTaskIsDone INTEGER)';
const createCollectionTable =
    'CREATE TABLE $dCollectionTable($dCollectionId INTEGER PRIMARY KEY, $dCollectionTitle TEXT)';
