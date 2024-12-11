const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const cors = require('cors');

const app = express();
const PORT = 3000;

app.use(bodyParser.json());
app.use(cors());

mongoose
    .connect('mongodb://localhost:27017/adoptpet', {
        useNewUrlParser: true,
        useUnifiedTopology: true,
    })
    .then(() => console.log('Connecté à MongoDB'))
    .catch((err) => console.error('Erreur de connexion à MongoDB:', err));

const dogSchema = new mongoose.Schema({
    name: { type: String, required: true },
    age: { type: Number, required: true },
    gender: { type: String, required: true },
    color: { type: String, required: true },
    weight: { type: Number, required: true },
    location: { type: String, required: true },
    image: { type: String, required: true },
    about: { type: String, required: true },
    owner: {
        name: { type: String, required: true },
        bio: { type: String, required: true },
        image: { type: String, required: true },
    },
});

const Dog = mongoose.model('Dog', dogSchema);

app.get('/', (req, res) => {
    res.send('Bienvenue sur l\'API AdoptPet');
});

app.get('/dogs', async (req, res) => {
    try {
        const dogs = await Dog.find();
        res.status(200).json(dogs);
    } catch (err) {
        res.status(500).json({ error: 'Erreur lors de la récupération des chiens' });
    }
});

app.get('/dogs/:id', async (req, res) => {
    try {
        const dog = await Dog.findById(req.params.id);
        if (!dog) {
            return res.status(404).json({ error: 'Chien introuvable' });
        }
        res.status(200).json(dog);
    } catch (err) {
        res.status(500).json({ error: 'Erreur lors de la récupération du chien' });
    }
});

app.post('/dogs', async (req, res) => {
    try {
        const dog = new Dog(req.body);
        await dog.save();
        res.status(201).json(dog);
    } catch (err) {
        res.status(400).json({ error: 'Erreur lors de l\'ajout du chien' });
    }
});

app.put('/dogs/:id', async (req, res) => {
    try {
        const dog = await Dog.findByIdAndUpdate(req.params.id, req.body, {
            new: true,
        });
        if (!dog) {
            return res.status(404).json({ error: 'Chien introuvable' });
        }
        res.status(200).json(dog);
    } catch (err) {
        res.status(400).json({ error: 'Erreur lors de la mise à jour du chien' });
    }
});

app.delete('/dogs/:id', async (req, res) => {
    try {
        const dog = await Dog.findByIdAndDelete(req.params.id);
        if (!dog) {
            return res.status(404).json({ error: 'Chien introuvable' });
        }
        res.status(200).json({ message: 'Chien supprimé avec succès' });
    } catch (err) {
        res.status(500).json({ error: 'Erreur lors de la suppression du chien' });
    }
});

app.listen(PORT, () => {
    console.log(`Serveur en cours d'exécution sur http://localhost:${PORT}`);
});
