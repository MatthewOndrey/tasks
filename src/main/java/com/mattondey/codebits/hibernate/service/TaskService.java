package com.mattondey.codebits.hibernate.service;

import java.util.List;

import com.mattondey.codebits.hibernate.dao.TaskDao;
import com.mattondey.codebits.hibernate.model.Task;

public class TaskService {

    private static TaskDao taskDao;

    public TaskService() {
        taskDao = new TaskDao();
    }

    public void persist(Task entity) {
        taskDao.openCurrentSessionwithTransaction();
        taskDao.persist(entity);
        taskDao.closeCurrentSessionwithTransaction();
    }
    public void update(Task entity) {
        taskDao.openCurrentSessionwithTransaction();
        taskDao.update(entity);
        taskDao.closeCurrentSessionwithTransaction();
    }

    public Task findById(String id) {
        taskDao.openCurrentSession();
        Task task = taskDao.findById(id);
        taskDao.closeCurrentSession();
        return task;
    }

    public void delete(String id) {
        taskDao.openCurrentSessionwithTransaction();
        Task task = taskDao.findById(id);
        taskDao.delete(task);
        taskDao.closeCurrentSessionwithTransaction();
    }

    public List<Task> findAll() {
        taskDao.openCurrentSession();
        List<Task> tasks = taskDao.findAll();
        taskDao.closeCurrentSession();
        return tasks;
    }

    public void deleteAll() {
        taskDao.openCurrentSessionwithTransaction();
        taskDao.deleteAll();
        taskDao.closeCurrentSessionwithTransaction();
    }

    public TaskDao taskDao() {
        return taskDao;
    }


}
