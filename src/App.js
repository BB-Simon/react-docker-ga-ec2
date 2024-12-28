import "./App.css";
import { useEffect, useState } from "react";

function App() {
  const [data, setData] = useState([]);
  const baseUrl =
    process.env.REACT_APP_NODE_ENV === "development"
      ? process.env.REACT_APP_LOCALE_BASE_URL
      : process.env.REACT_APP_SERVER_BASE_URL;

  useEffect(() => {
    fetch(`${baseUrl}/users`)
      .then((response) => response.json())
      .then((data) => setData(data));
  }, []);

  return (
    <div className="App">
      <div className="container">
        <h1>
          Run node and react app on aws ec2 instance using docker and github
          actions
        </h1>
        <div>
          {data.length > 0 &&
            data.map((user) => (
              <div key={user._id}>
                <p>User Name: {user.name}</p>
                <p>User bio: {user.bio}</p>
              </div>
            ))}
        </div>
      </div>
    </div>
  );
}

export default App;
