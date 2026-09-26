script "PlayerControl"

on TestPlayerProperties
   local tStack, tIsPaused
	constant kWavPath = "tests/lcs/core/multimedia/silence.wav"
	constant kWaitTime = 200
   create stack "temp_player_test_stack"
   put the name of stack "temp_player_test_stack" into tStack
   open stack tStack
   
   create player "test_player" in card 1 of stack tStack
   TestAssert "player created", there is a player "test_player" of card 1 of stack tStack
   
   -- Set up the test wav file
	set the itemDelimiter to slash
   set the filename of player "test_player" of card 1 of stack tStack to kWavPath
   TestAssert "filename set", the filename of player "test_player" of card 1 of stack tStack contains item -1 of kWavPath
	set the itemDelimiter to comma

   -- Check default loudness and looping properties
   set the playLoudness of player "test_player" of card 1 of stack tStack to 50
   TestAssert "playLoudness set", the playLoudness of player "test_player" of card 1 of stack tStack is 50

   set the looping of player "test_player" of card 1 of stack tStack to true
   TestAssert "looping set to true", the looping of player "test_player" of card 1 of stack tStack is true
   set the looping of player "test_player" of card 1 of stack tStack to false
   TestAssert "looping set to false", the looping of player "test_player" of card 1 of stack tStack is false

   -- Test play/pause/stop commands
   -- Initially the player is paused/stopped on load
   TestAssert "initially paused", the paused of player "test_player" of card 1 of stack tStack is true

   -- Start the player
   start player "test_player" of card 1 of stack tStack
   wait kWaitTime milliseconds
	put the paused of player "test_player" of card 1 of stack tStack is false into tIsPaused
   TestAssert "is playing", tIsPaused
#   TestAssert "is playing", the paused of player "test_player" of card 1 of stack tStack is not true

   set the currentTime of player "test_player" of card 1 of stack tStack to 30
   wait kWaitTime milliseconds
   TestAssert "currentTime set to 30", the currentTime of player "test_player" of card 1 of stack tStack is 30
   set the currentTime of player "test_player" of card 1 of stack tStack to 500
   wait kWaitTime milliseconds
   TestAssert "currentTime set to 500", the currentTime of player "test_player" of card 1 of stack tStack is 500

   -- Pause the player
   set the paused of player "test_player" of card 1 of stack tStack to true
   wait kWaitTime milliseconds
   TestAssert "is paused", the paused of player "test_player" of card 1 of stack tStack is true

   -- Start again
   start player "test_player" of card 1 of stack tStack
   wait kWaitTime milliseconds
	put the paused of player "test_player" of card 1 of stack tStack is false into tIsPaused
   TestAssert "is playing", tIsPaused
#   TestAssert "is playing again", the paused of player "test_player" of card 1 of stack tStack is false

   -- Stop the player
   stop player "test_player" of card 1 of stack tStack
   wait kWaitTime milliseconds
   TestAssert "is stopped", the paused of player "test_player" of card 1 of stack tStack is true

   -- Clean up
   delete player "test_player" of card 1 of stack tStack
   close stack tStack
   delete stack tStack
end TestPlayerProperties
