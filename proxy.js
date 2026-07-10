const net = require('net');

const PROXY_PORT = parseInt(process.env.PROXY_PORT || '5678', 10);
const N8N_PORT = parseInt(process.env.N8N_PORT || '5679', 10);
const UPSTREAM_HOST = process.env.UPSTREAM_HOST || '127.0.0.1';

const server = net.createServer((clientConn) => {
  let upstreamConn = null;
  let buffer = [];
  let connected = false;

  const tryConnect = () => {
    const conn = net.connect(N8N_PORT, UPSTREAM_HOST);
    conn.on('connect', () => {
      upstreamConn = conn;
      connected = true;
      if (buffer.length > 0) {
        conn.write(Buffer.concat(buffer));
        buffer = [];
      }
      clientConn.pipe(conn).on('error', () => {});
      conn.pipe(clientConn).on('error', () => {});
    });
    conn.on('error', () => {
      conn.destroy();
      setTimeout(tryConnect, 500);
    });
  };

  clientConn.on('data', (chunk) => {
    if (connected && upstreamConn) {
      upstreamConn.write(chunk);
    } else {
      buffer.push(chunk);
    }
  });

  clientConn.on('end', () => {
    if (upstreamConn) upstreamConn.end();
  });

  clientConn.on('error', () => {});

  tryConnect();
});

server.listen(PROXY_PORT, '0.0.0.0', () => {
  console.log(`Proxy listening on 0.0.0.0:${PROXY_PORT} -> ${UPSTREAM_HOST}:${N8N_PORT}`);
});

process.on('SIGTERM', () => {
  server.close(() => process.exit(0));
});
