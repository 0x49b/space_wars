class Stats{
  
  int shotsFired = 0;
  int heartsCollected = 0;
  int shieldsCollected = 0;
  int asteroidsHit = 0;
  int score = 0;
  
  public Stats(){}
  
  public void addShot(){ shotsFired++;} 
  public void addHeart(){ 
    heartsCollected++;
    score += int(random(5, 20));
  }
  
  public void addShield(){
    shieldsCollected++;
    score += int(random(5, 30));
  }
  public void addAsteroidHit(){asteroidsHit++;}
  
  public void resetStats(){
    shotsFired = 0;
    heartsCollected = 0;
    shieldsCollected = 0;
    asteroidsHit = 0;
    resetScore();
  }
  
  
  
  public void incrementScore(){
    score += int(random(1, 10));
  }
  
  public void decrementScore(){
    score -= 25;
  }
  
  public void resetScore(){
    score = 0;
  }
  
  public float getHitRate(){
    if( shotsFired > 0 ){
    return asteroidsHit / shotsFired;
    }
    return 0;
  }
  
  public String getStatsDebug(){
    return "Shots Fired: " + shotsFired + " Hearts Collected: " + heartsCollected + " Shields Collected: " + shieldsCollected + " Asteroids Hit:  " + asteroidsHit + " Hit Rate: " + getHitRate();
  }
  
  public int getScore(){
    return score;
  }
  
  public int getShotsFired(){
    return shotsFired;
  }
  
  public int getHeartsCollected(){
    return heartsCollected;
  }
  
  public int getShieldsCollected(){
    return shieldsCollected;
  }
  
  public int getAsteroidsHit(){
    return asteroidsHit;
  }

}
