

import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS = 10;
public final static int NUM_COLS = 10;
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
  for(int x = 0; x < 10; x++){
   int r = (int)(Math.random()*(NUM_ROWS));
   int c = (int)(Math.random()*(NUM_COLS));
    if(isValid(r,c) && has(r,c) == false){
     mines.add(new MSButton(r,c));
     System.out.println(r +"," +c);
     buttons[r][c].marked=true;
    }
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
    for(int x = 0; x < mines.size();x++)
    if(mines.get(x).flagged==false)
    return false;

    return true;
}
public void displayLosingMessage()
{
    for( int r =0; r < NUM_ROWS; r++){
    for (int c = 0; c < NUM_COLS; c++){
      buttons[r][c].clicked=true;
      buttons[r][c].setLabel("L"); 
    } 
    } 
}

public void displayWinningMessage()
{
    for( int r =0; r < NUM_ROWS; r++){
    for (int c = 0; c < NUM_COLS; c++){
      buttons[r][c].setLabel("W");
      buttons[r][c].clicked=true;
      buttons[r][c].setLabel("W");
    } 
    } 
}
public int countMines(int row, int col)
{
    int count = 0;
    
for(int r = row-1; r<= row+1; r++)
for(int c = col-1; c<= col+1; c++)
for(int x = 0; x<mines.size(); x++)
if(isValid(r,c) && mines.get(x).myRow == buttons[r][c].myRow && mines.get(x).myCol == buttons[r][c].myCol)
count++;
    return count;
}
public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
    private boolean marked;
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
        Interactive.add( this ); 
        marked = false;
    }

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
      
      if(countMines(myRow,myCol)>0)
       this.setLabel(countMines(myRow,myCol));
  
       if(mouseButton == LEFT)
  for(int r= myRow-1; r<= myRow+1; r++)
  for(int c= myCol-1; c<= myCol+1; c++)
  if(isValid(r,c) && has(r,c)==false && buttons[r][c].clicked==false && countMines(r,c) ==0)
  buttons[r][c].mousePressed(); 
  /*if(has(r,c-1)==false)
  if(has(r,c+1)==false)
  if(has(r-1,c-1)==false)
  if(has(r+1,c+1)==false)
  if(has(r+1,c)==false)
  if(has(r-1,c)==false)
  if(has(r-1,c+1)==false)
  if(has(r+1,c-1)==false)*/
   
 
    
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
    if(r<0 || r> NUM_ROWS-1 || c<0 || c>NUM_COLS-1)
    return false;
    
    return true;
}

  public boolean has(int r, int c){
  boolean yes = false;
for(int x = 0; x<mines.size(); x++)
if(isValid(r,c) && mines.get(x).myRow == buttons[r][c].myRow && mines.get(x).myCol == buttons[r][c].myCol)
yes = true;
    return yes;
}
