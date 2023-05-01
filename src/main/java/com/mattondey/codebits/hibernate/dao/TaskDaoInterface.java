package com.mattondey.codebits.hibernate.dao;

import java.io.Serializable;
import java.util.List;

public abstract class TaskDaoInterface<T, Id extends Serializable> {
    public abstract void persist(T entity);

    public abstract void update(T entity);

    public abstract T findById(Id id);

    public abstract void delete(T entity);

    public abstract List<T> findAll();

    public abstract void deleteAll();
}
