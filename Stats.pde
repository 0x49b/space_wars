class Stats{
  
  int shotsFired = 0;
  int heartsCollected = 0;
  int shieldsCollected = 0;
  int asteroidsHit = 0;
  int score = 0;
  
  public Stats(){}
  
  public void addShot(){ shotsFired++;}
  public void addHeart(){ heartsCollected++;}
  public void addShield(){shieldsCollected++;}
  public void addAsteroidHit(){asteroidsHit++;}
  
  public void resetStats(){
    shotsFired = 0;
    heartsCollected = 0;
    shieldsCollected = 0;
    asteroidsHit = 0;
    resetScore();
  }
  
  public void incrementScore(){
    score += 10;
  }
  
  public void decrementScore(){
    score -= 25;
  }
  
  public int getScore(){
    return score;
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

}
