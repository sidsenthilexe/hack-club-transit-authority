extends AudioStreamPlayer2D

var currentTrack: int = 0
var totalTracks: int = stream.streams_count

func play_track(n:int) -> void:
	for i in range(posmod(n - currentTrack, totalTracks) + 1):
		play()
		currentTrack += 1
