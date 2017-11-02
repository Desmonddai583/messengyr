import React from 'react';
import ReactDOM from 'react-dom';
import 'whatwg-fetch'; 

import ChatContainer from "./components/chat-container";
import MenuContainer from "./components/menu-container";

class App extends React.Component {
  componentDidMount() {
    fetch('/api/rooms', {
      headers: {
        "Authorization": "Bearer " + window.jwtToken,
      },
    })
    .then((response) => {
      return response.json()
    })
    .then((response) => {
      let rooms = response.rooms;
      this.setState({
        rooms: rooms,
        messages: rooms[0].messages,
      });
    })
    .catch((err) => {
      console.error(err);
    });
  }

  constructor() {
    super();

    this.state = {
      rooms: [],
      messages: [],
    };
  }

  render() {
    return (
      <div>
        <MenuContainer
          rooms={this.state.rooms}
        />
        <ChatContainer
          messages={this.state.messages}
        />
      </div>
    )
  }
}

ReactDOM.render(
  <App />,
  document.getElementById('app'),
);
