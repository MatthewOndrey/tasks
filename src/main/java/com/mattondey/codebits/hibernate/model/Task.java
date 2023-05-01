package com.mattondey.codebits.hibernate.model;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "tasks")

public class Task {
    @Id
    @GeneratedValue
    @Column(name = "id")
    private int id;

    @Column(name = "title")
    private String taskTitle;

    @Column(name = "description")
    private String taskDescription;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "due_date")
    private Date taskDueDate;

    public int getTaskId() {
        return id;
    }

    public String getTaskTitle() {
        return taskTitle;
    }

    public void setTaskTitle() {
        this.taskTitle = taskTitle;
    }

    public String getTaskDescription() {
        return taskDescription;
    }

    public void setTaskDescription() {
        this.taskDescription = taskDescription;
    }

    public Date getTaskDueDate() {
        return taskDueDate;
    }

    public void setTaskDueDate() {
        this.taskDueDate = taskDueDate;
    }

    @Override
    public String toString() {
        return "Task: " + this.id + ", " + this.taskTitle + ", " + this.taskDescription + ", " + this.taskDueDate;
    }
}
