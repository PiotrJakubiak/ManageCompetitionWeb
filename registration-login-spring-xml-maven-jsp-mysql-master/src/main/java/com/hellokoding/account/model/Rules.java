package com.hellokoding.account.model;

import javax.persistence.*;
import java.util.Set;

/**
 * Created by Piotrek on 02-Jan-17.
 */
@Entity
@Table(name = "rules")
public class Rules {


    private long id;
    private String fileName;
    private byte[] data;
    private Set<Tournament> tournaments;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }
    @Column(name = "FILE_DATA")
    public byte[] getData() {
        return data;
    }

    public void setData(byte[] data) {
        this.data = data;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }
    @OneToMany(mappedBy = "rules")
    public Set<Tournament> getTournaments() {
        return tournaments;
    }

    public void setTournaments(Set<Tournament> tournaments) {
        this.tournaments = tournaments;
    }
}
