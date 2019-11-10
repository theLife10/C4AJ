package c4.ext;

import java.awt.Color;

import c4.base.BoardPanel;
import c4.base.C4Dialog;
import c4.base.ColorPlayer;

public privileged aspect AddOpponent {
	private BoardPanel C4Dialog.boardPanel;
	//init players
	ColorPlayer blue = new ColorPlayer("Blue", Color.BLUE);
	ColorPlayer red = new ColorPlayer("Red", Color.RED);
	
	//restarts the board
	after(C4Dialog d) returning (BoardPanel boardpanel):
		this(d) && call(BoardPanel.new(..)){
		d.boardPanel= boardpanel;
		
	}
	//switches players
	after(C4Dialog d): this(d) && execution(void C4Dialog.makeMove(..)) {
		if (d.player.name().equals("Blue")) {
			d.player = red;
			d.boardPanel.setDropColor(d.player.color());
			d.showMessage(d.player.name() + "'s turn");

		} else if (d.player.name().equals("Red")) {

			d.player = blue;
			d.boardPanel.setDropColor(d.player.color());
			d.showMessage(d.player.name() + "'s turn");

		}

	}
}