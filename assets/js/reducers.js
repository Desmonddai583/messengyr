export const messages = (state = [], action) => {
  switch (action.type) {
    case "ADD_MESSAGE":
      // Add the new message to the list of messages:
      return [
        ...state,
        action.message,
      ];

    default:
      return state;
  }
};

const room = (state, action) => {
  switch (action.type) {
    case "SELECT_ROOM":
      let isActive = (state.id === action.roomId);

      return Object.assign({}, state, {
        isActive,
      });

    case "ADD_MESSAGE":
      // If the action's "roomId" isn't this room,
      // don't change the state of the room, just return it:
      if (state.id !== action.roomId) {
        return state;
      }

      // Edit the "messages" object of this room:
      return Object.assign({}, state, {
        messages: messages(state.messages, action)
      });

    default:
      return state;
  }
};

const rooms = (state = [], action) => {
  switch (action.type) {
    case "SET_ROOMS":
      return action.rooms;

    case "SELECT_ROOM":
      // Loop through the rooms:
      return state.map(r => {
        // Determine the state of each room:
        return room(r, action);
      });

    case "ADD_ROOM":
      return [
        action.room,
        ...state,
      ];

    case "ADD_MESSAGE":
      return state.map(r => {
        return room(r, action);
      });

    default:
      return state;
  }
};

export default rooms;