package c4.ext;

import c4.base.BoardPanel;
import java.awt.*;
import java.awt.event.*;

public privileged aspect PressDisc {
	private int BoardPanel.click=-1;
	
	
	pointcut diskpress(BoardPanel boardpanel):
		execution(BoardPanel.new(..)) && this(boardpanel);
		
	after(BoardPanel boardpanel):diskpress(boardpanel){
		boardpanel.addMouseListener(new MouseAdapter() {
			@Override
			public void mousePressed(MouseEvent e) {
				if(!boardpanel.board.isGameOver()) {
					boardpanel.click = boardpanel.locateSlot(e.getX(), e.getY());
					boardpanel.repaint();
				}
			}
			@Override
			public void mouseReleased(MouseEvent e) {
				if(!boardpanel.board.isGameOver()) {
					boardpanel.click=-1;
					boardpanel.repaint();
				}
			}
		});
	}
	
	
	
	pointcut drawMiniDisk (BoardPanel boardpanel, Graphics graphic):
		execution(void BoardPanel.drawDroppableCheckers(Graphics)) && 
		this(boardpanel) && args(graphic);
	
	after(BoardPanel boardpanel, Graphics graphics) : drawMiniDisk(boardpanel,graphics){
		if(boardpanel.click >= 0) {
			boardpanel.drawChecker(graphics, boardpanel.dropColor, boardpanel.click, -1, 0);
			boardpanel.drawChecker(graphics, Color.WHITE, boardpanel.click, -1, 6);
		}
	}
	
	
}