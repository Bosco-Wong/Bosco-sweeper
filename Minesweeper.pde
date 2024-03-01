
import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS = 2;
public final static int NUM_COLS = 1;
private MSButton[][] buttons; //2d array of minesweeper buttons
 ArrayList <MSButton> mines = new ArrayList <MSButton>();
void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to initialize buttons goes here
    //fist call to new
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for( int r =0; r < NUM_ROWS; r++){
    for (int c=0; c < NUM_COLS; c++){
      buttons[r][c] = new MSButton(r,c);
    }
    }
    
    setMines();
}
public void setMines()
{
  for(int x = 0; x < NUM_ROWS*2; x++){
   int r = (int)(Math.random()*(NUM_ROWS));
   int c = (int)(Math.random()*(NUM_COLS));
   if(mines.contains(buttons[r][c]) == false)
   mines.add(new MSButton(r,c));
  }
}

public void draw ()
{
    background( 0 );
    if(isWon() == true)
        displayWinningMessage();
}
public boolean isWon()
{
    if(mines.size() > 0)
    return false;

    return true;
}
public void displayLosingMessage()
{
    for( int r =0; r < NUM_ROWS; r++){
    for (int c = 0; c < NUM_COLS; c++){
      buttons[r][c].setLabel("L");
      buttons[r][c].mousePressed();
      buttons[r][c].setLabel("L");
    }
    }
}
public void displayWinningMessage()
{
    for( int r =0; r < NUM_ROWS; r++){
    for (int c= 0; c < NUM_COLS; c++){
      buttons[r][c].setLabel("W");
    }
    }
}
public int countMines(int row, int col)
{
    int numMines = 1;
    for(int r = row -1; r < row +2; r++){
    for(int c = col-1; c < col + 2; c++)
    if(isValid(r,c) == true && mines.contains(buttons[r][c]) == true)
    numMines++;
    }
    return numMines;
}
public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
    
    public MSButton ( int row, int col )
    {
         width = 400/NUM_COLS;
         height = 400/NUM_ROWS;
        myRow = row;
        myCol = col; 
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add( this ); // register it with the manager
    }

    // called by manager
    public void mousePressed () 
    {
        clicked = true;
        if(mouseButton == RIGHT){
        if(flagged == true){
        flagged = false;
        clicked = false;
        }
        else if(flagged == false)
        flagged = true;
        }
        else if(mines.contains(this) == true)
        displayLosingMessage();
        else
        this.setLabel(countMines(this.myRow, this.myCol));
        
        
       
  
    }
    public void draw () 
    {    
        if (flagged)
            fill(0);
        else if( clicked && mines.contains(this) ) 
             fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }


}


     public boolean isValid(int r, int c)
{
    if(r<0 || r>= NUM_ROWS || c<0 || c>=NUM_COLS)
    return false;
    
    return true;
}

