// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract TodoList {

    //Representation of task

    struct Task {
        uint256 id;
        string description;
        bool isDone;
    }

    // Mapping to store tasks by their ID

    mapping(uint256 => Task) public tasks;

    // Counter for generating unique task ID

    uint256 public taskCount;

    // Event for task creation

    event TaskCreated(uint256 id, string description);

    // Event for  task completion

    event TaskCompleted(uint256 id);

    // Event for task removal

    event TaskRemoved(uint256 id);

    // Function to add a new task

    function addTask(string memory _description) external {
        taskCount++;

        tasks[taskCount] = Task(taskCount, _description, false);

        emit TaskCreated(taskCount, _description);
    }

    // Function for done tasks

    function completeTask(uint256 _taskId) external {

        require(_taskId > 0 && _taskId <= taskCount, "Invalid task ID");

        require(!tasks[_taskId].isDone, "Task Completed Weldone");

        tasks[_taskId].isDone = true;

        emit TaskCompleted(_taskId);
    }

    // Function to remove a task

    function removeTask(uint256 _taskId) external {

        require(_taskId > 0 && _taskId <= taskCount, "Invalid task ID");

        delete tasks[_taskId];
        emit TaskRemoved(_taskId);
    }

    // Function to get task details

    function getTask(uint256 _taskId) external view returns (uint256, string memory, bool) {

        require(_taskId > 0 && _taskId <= taskCount, "Invalid task ID");

        Task memory task = tasks[_taskId];
        
        return (task.id, task.description, task.isDone);
    }
}
