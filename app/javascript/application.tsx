import React from 'react';
import ReactDOM from 'react-dom';

const App = (): JSX.Element => {
  return <h1>Hello World!</h1>;
};

ReactDOM.render(<App />, document.querySelector('#spa'));
