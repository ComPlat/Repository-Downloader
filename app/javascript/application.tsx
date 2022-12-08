import React from 'react';
import ReactDOM from 'react-dom';
import SwaggerUI from 'swagger-ui-react';

const App = (): JSX.Element => {
  return <SwaggerUI url='/api/swagger_doc.json' />;
};

ReactDOM.render(<App />, document.querySelector('#spa'));
