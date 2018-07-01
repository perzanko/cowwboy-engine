import { Socket } from "phoenix"

class Playrooms {
  constructor() {
    this.playrooms = document.getElementById('playrooms');
    if (!this.playrooms) return;
    
    this.socket = new Socket("/socket", {params: {token: 'egrdsfgrtyerfw'}})

    this.init();
  }


  connect() {
    this.socket.connect()

    // Now that you are connected, you can join channels with a topic:
    this.channel = this.socket.channel("playrooms", {})
    this.channel.join()
      .receive("ok", resp => { console.log("Joined successfully", resp); this.renderPlayrooms(resp); })
      .receive("error", resp => { console.log("Unable to join", resp) })
  }


  getTestCommands() {
    this.channel.push('playrooms:test_commands')
      .receive("ok", ({ commands }) => this.renderCommandsButtons(commands));
  }


  getTestListeners() {
    this.channel.push('playrooms:test_listeners')
      .receive("ok", ({ listeners }) => {
        this.renderListenersList(listeners);
        listeners.forEach((x) => {
          this.channel.on(x, (resp) => console.log(`on ${x} =>`, resp));
        })
      });
  }


  renderPlayrooms({ playrooms }) {
    const playroomsWrapper = document.getElementById('playrooms_playrooms');
    const listItems = playrooms.map((x) => (
      `<tr> <th scope="row">${x.id}</th> <td>${x.name}</td> <td>${x.private ? 'true' : 'false'}</td> <td>${x.pin ? x.pin : '-'}</td><td>${x.slots ? x.slots.map((x, i) => `${i > 0 ? ' ' : ''}${i + 1}: ${x}`) : '-'}</td> </tr>`
    )).join('');
    playroomsWrapper.innerHTML = `
      <div class="list-group-item">
        <table class="table table-striped">
        <thead><tr><th>ID</th><th>Name</th><th>Private</th><th>PIN</th><th>Slots</th></tr></thead>
        <tbody>${listItems}</tbody>
      </div>
    `;
  }


  renderListenersList(listeners) {
    const listenersWrapper = document.getElementById('playrooms_listeners');
    const listItems = listeners.map((x) => (
      `<li class="list-group-item">${x}</li>`
    )).join('');
    listenersWrapper.innerHTML = `<ul class="list-group">${listItems}</ul>`;
  }


  renderCommandsButtons(commands) {
    const buttonWrapper = document.getElementById('playrooms_buttons');
    const buttons = commands.map((x) => (
      `<li class="list-group-item">
        <button
          class="btn btn-success"
          id="command-button__${x.command}"
          type="button"
          data-name="${x.command}"
          data-payload='${JSON.stringify(x.payload)}'
        >
          Push ${x.command}
        </button>
        <small style="display: block; margin-top: 10px" class="pull-right">${JSON.stringify(x.payload)}</small>
        </li>`
    )).join('');
    buttonWrapper.innerHTML = `<ul class="list-group">${buttons}</ul>`;
    buttonWrapper.querySelectorAll('button').forEach((item) => {
      item.addEventListener('click', () => {
        const name = item.getAttribute('data-name');
        const payload = JSON.parse(item.getAttribute('data-payload'));
        console.log('send push', name);
        this.channel
          .push(name, payload)
          .receive("ok", resp => { console.log(`OK - push ${name} response ->`, resp); })
          .receive("error", resp => { console.log(`ERROR - push ${name} response ->`, resp); })
      })
    })
  }


  init() {
    this.connect();
    this.getTestCommands();
    this.getTestListeners();
  }
}


new Playrooms();

