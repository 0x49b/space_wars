import mqtt.*;
import java.util.UUID;


class MultiplayerScreen implements Screen{
  
  MQTTClient client;
  String gameId;
  
  public MultiplayerScreen(PApplet cp5Applet){
    cp5 = new ControlP5(cp5Applet);
    cp5.addButton("menu").setPosition(25,25);
    cp5.hide();
    client = new MQTTClient(cp5Applet);
    
    gameId = UUID.randomUUID().toString();
    
  }

  public void draw(){
    background(0);
    cp5.show();
    
    if(frameCount % (60*5) == 0){
      client.publish("/game", "{\"gameid\": \""+gameId+"\"}");
    }
    
  }
  
  public void connectClient(){
    client.connect("mqtt://public:public@public.cloud.shiftr.io", "maxbrax");
    client.subscribe("/dati");
  }
  
  public void disconnectClient(){
    client.unsubscribe("/game");
    client.disconnect();
  }
  
  public void hideControls(){
    cp5.hide();
  }
}
