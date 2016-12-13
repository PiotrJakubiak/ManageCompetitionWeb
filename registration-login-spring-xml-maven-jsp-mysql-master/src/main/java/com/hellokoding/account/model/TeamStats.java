package com.hellokoding.account.model;

import java.util.Comparator;

/**
 * Created by Piotrek on 11-Dec-16.
 */
public class TeamStats {

    private String name;
    private int countMatch;
    private int countWin;
    private int countDraw;
    private int countFail;
    private int countPoints;
    private int countGoalScored;
    private int countGoalLost;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getCountMatch() {
        return countMatch;
    }

    public void setCountMatch(int countMatch) {
        this.countMatch = countMatch;
    }

    public int getCountPoints() {
        return countPoints;
    }

    public void setCountPoints(int countPoints) {
        this.countPoints = countPoints;
    }

    public int getCountGoalScored() {
        return countGoalScored;
    }

    public void setCountGoalScored(int countGoalScored) {
        this.countGoalScored = countGoalScored;
    }

    public int getCountGoalLost() {
        return countGoalLost;
    }

    public void setCountGoalLost(int countGoalLost) {
        this.countGoalLost = countGoalLost;
    }

    public int getCountFail() {
        return countFail;
    }

    public void setCountFail(int countFail) {
        this.countFail = countFail;
    }

    public int getCountDraw() {
        return countDraw;
    }

    public void setCountDraw(int countDraw) {
        this.countDraw = countDraw;
    }

    public int getCountWin() {
        return countWin;
    }

    public void setCountWin(int countWin) {
        this.countWin = countWin;
    }

}
