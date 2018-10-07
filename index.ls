require! {
  fs
  http
  moment
  util: { inspect }
  'request-promise': request
  './config': config
}

options = (url, query={}) -> do
    uri: url,
    qs: query

console.log 'querying...', config
request options 'https://grbsrv.opengribs.org/getmygribs.php', config
.then ->
  { status, message } = JSON.parse(it)
  console.log message
  filename = "/home/lesh/" + moment().format('YYYYMMDD') + ".grb"
  console.log 'downloading to', filename
  file = fs.createWriteStream(filename);
  http.get message.url, (res) -> 
    res.pipe file
