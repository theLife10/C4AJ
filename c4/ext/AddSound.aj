package c4.ext;

import java.io.IOException;
import javax.sound.sampled.AudioInputStream;
import javax.sound.sampled.AudioSystem;
import javax.sound.sampled.Clip;
import javax.sound.sampled.LineUnavailableException;
import javax.sound.sampled.UnsupportedAudioFileException;
import c4.base.C4Dialog;

privileged aspect AddSound {
	private static final String sound = "/sound/"; 
	
	after(C4Dialog c4Dialog) : execution(* C4Dialog.makeMove(int)) && this(c4Dialog) {  
        if(c4Dialog.player.name() == "Blue"){
             	playAudio("click.wav");
        }
        if(c4Dialog.player.name() == "Red"){
                playAudio("click.wav");
        }
	}
	
    public static void playAudio(String filename) {
        try {
            AudioInputStream audioIn = AudioSystem.getAudioInputStream(
              AddSound.class.getResource(sound + filename));
            Clip clip = AudioSystem.getClip();
            clip.open(audioIn);
            clip.start();
        } catch (UnsupportedAudioFileException 
              | IOException | LineUnavailableException e) {
            e.printStackTrace();
        }
      }
}