const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');

const app = express();
const port = 3000;

app.use(bodyParser.json());

mongoose.connect('mongodb://localhost:27017/adoptpet', {
  useNewUrlParser: true,
  useUnifiedTopology: true,
});

mongoose.connection.once('open', () => {
  console.log('Connected to MongoDB');
});

const dogSchema = new mongoose.Schema({
  name: String,
  age: Number,
  gender: String,
  color: String,
  weight: Number,
  location: String,
  image: String,
  about: String,
});

const Dog = mongoose.model('Dog', dogSchema);
app.get('/dogs', async (req, res) => {
  const dogs = await Dog.find();
  res.json(dogs);
});

app.post('/dogs', async (req, res) => {
  const newDog = new Dog(req.body);
  await newDog.save();
  res.json(newDog);
});

app.put('/dogs/:id', async (req, res) => {
  const updatedDog = await Dog.findByIdAndUpdate(req.params.id, req.body, { new: true });
  res.json(updatedDog);
});

app.delete('/dogs/:id', async (req, res) => {
  await Dog.findByIdAndDelete(req.params.id);
  res.json({ message: 'Dog deleted successfully' });
});

app.listen(port, () => {
  console.log(`Server running on http://localhost:${port}`);
});
