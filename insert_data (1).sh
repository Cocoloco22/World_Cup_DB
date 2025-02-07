#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNERGOALS OPPONENTGOALS

#insert each unique winner/opponent to the teams table
do
if [[ $WINNER != winner ]]
then
  #get winner_name
  $WINNER_NAME=$($PSQL "SELECT name FROM teams WHERE name='$WINNER' ")
  #if not found 
    if [[ -z $WINNER_NAME ]]
    then
  #insert winner name
    INSERT_WINNER_NAME=$($PSQL "INSERT INTO teams(name) VALUES ('$WINNER') ")
      if [[ $INSERT_WINNER_NAME == "INSERT 0 1" ]]
      then
        echo "Inserted into teams, $WINNER"
      fi
  #get new winner name
    $WINNER_NAME=$($PSQL "SELECT name FROM teams WHERE name='$WINNER' ")
    fi

  #get opponent_name
  $OPPONENT_NAME=$($PSQL "SELECT name FROM teams WHERE name='$OPPONENT' ")
  #if not found
    if [[ -z $OPPONENT_NAME ]]
    then
  #insert opponent name
    INSERT_OPPONENT_NAME=$($PSQL "INSERT INTO teams(name) VALUES ('$OPPONENT') ")
      if [[ $INSERT_OPPONENT_NAME == "INSERT 0 1" ]]
      then 
        echo "Inserted into teams, $OPPONENT"
      fi
  #get new opponent name
    $OPPONENT_NAME=$($PSQL "SELECT name FROM teams WHERE name='$OPPONENT' ")
    fi

#connecting team_id to the winner_id/opponent_id
#get winner_id
$WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER' ")
#if not found
  if [[ -z $WINNER_ID ]]
  then
#insert winner_id
  INSERT_WINNER_ID=$($PSQL "INSERT INTO games(winner_id) VALUES ('$WINNER_ID') ")
    if [[ $INSERT_WINNER_ID == "INSERT 0 1" ]]
    then
      echo "Inserted into games, $WINNER_ID"
    fi
#get new winner_id
  $WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER' ")
  fi

#get opponent_id
$OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT' ")
#if not found
  if [[ -z $OPPONENT_ID ]]
  then
#insert opponent_id
  INSERT_OPPONENT_ID=$($PSQL "INSERT INTO games(opponent_id) VALUES ('$OPPONENT_ID') ")
    if [[ $INSERT_OPPONENT_ID == "INSERT 0 1" ]]
    then
      echo "Inserted into games, $OPPONENT_ID"
    fi
#get new opponent_id
  $OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPPONENT' ")
  fi

#insert data from games.csv into games table
#INSERT_GAME_RESULTS=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES ('$YEAR', '$ROUND', '$WINNER_ID', '$OPPONENT_ID', '$WINNERGOALS', '$OPPONENTGOALS')")
  #if [[ $INSERT_GAME_RESULTS == "INSERT 0 1" ]]
  #then
    #echo "Inserted into games, $YEAR: $ROUND: $WINNER_ID: $OPPONENT_ID: $WINNERGOALS: $OPPONENTGOALS"
 # fi


fi

done