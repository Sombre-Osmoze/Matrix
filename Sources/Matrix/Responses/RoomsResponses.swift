//
//  RoomsResponses.swift
//  Matrix
//
//  Created by Marcus Florentin on 24/04/2021.
//

import Foundation


public struct JoinedRoomResponse: ResponsesAPI {

	/// The joined rooms of the user.
	public let joinedRooms : [RoomID]

}
