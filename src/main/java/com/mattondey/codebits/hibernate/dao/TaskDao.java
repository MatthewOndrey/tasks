package com.mattondey.codebits.hibernate.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.Configuration;

import com.mattondey.codebits.hibernate.model.Task;

public class TaskDao extends TaskDaoInterface<Task, String> {
    private Session currentSession;

    private Transaction currentTransaction;

    public TaskDao() {
    }

    public Session openCurrentSession() {
        currentSession = getSessionFactory().openSession();
        return currentSession;
    }

    public Session openCurrentSessionwithTransaction() {
        currentSession = getSessionFactory().openSession();
        currentTransaction = currentSession.beginTransaction();
        return currentSession;
    }

    public void closeCurrentSession() {
        currentSession.close();
    }

    public void closeCurrentSessionwithTransaction() {
        currentTransaction.commit();
        currentSession.close();
    }

    private static SessionFactory getSessionFactory() {
        Configuration configuration = new Configuration().configure();
        StandardServiceRegistryBuilder builder = new StandardServiceRegistryBuilder()
                .applySettings(configuration.getProperties());
        SessionFactory sessionFactory = configuration.buildSessionFactory(builder.build());
        return sessionFactory;
    }

    public Session getCurrentSession() {
        return currentSession;
    }

    public void setCurrentSession(Session currentSession) {
        this.currentSession = currentSession;
    }

    public Transaction getCurrentTransaction() {
        return currentTransaction;
    }

    public void setCurrentTransaction(Transaction currentTransaction) {
        this.currentTransaction = currentTransaction;
    }

    public void persist(Task entity) {
        getCurrentSession().save(entity);
    }

    public void update(Task entity) {
        getCurrentSession().update(entity);
    }

    public Task findById(String id) {
        Task task = (Task) getCurrentSession().get(Task.class, id);
        return task;
    }

    public void delete(Task entity) {
        getCurrentSession().delete(entity);
    }

    @SuppressWarnings("unchecked")
    public List<Task> findAll() {
        List<Task> tasks = (List<Task>) getCurrentSession().createQuery("from Task").list();
        return tasks;
    }

    public void deleteAll() {
        List<Task> entityList = findAll();
        for (Task entity : entityList) {
            delete(entity);
        }
    }
}