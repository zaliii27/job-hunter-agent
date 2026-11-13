// Makes an exported n8n workflow safe to publish on GitHub.
// Chat ID and Sheet ID are already {{ $env.* }} expressions, so only credential IDs need hiding.
// Usage (inside the n8n container): node sanitize.js <exported.json> <public.json>
const fs = require('fs');

let w = JSON.parse(fs.readFileSync(process.argv[2], 'utf8'));
if (Array.isArray(w)) w = w[0];

for (const n of w.nodes || []) {
  if (n.credentials) {
    for (const type of Object.keys(n.credentials)) {
      n.credentials[type] = { id: 'YOUR_' + type.toUpperCase() + '_ID', name: n.credentials[type].name };
    }
  }
}
delete w.meta;       // instance ID of my n8n
delete w.versionId;
delete w.shared;     // owner info
w.active = false;

fs.writeFileSync(process.argv[3], JSON.stringify(w, null, 2) + '\n');
console.log('clean copy:', process.argv[3]);
