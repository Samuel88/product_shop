const arr1 = [
    { id: 1, name: "Samuel", skill: "Talk to pidgeon" },
    { id: 1, name: "Samuel", skill: "Juggling" },
    { id: 1, name: "Samuel", skill: "Speed reading" },
    { id: 1, name: "Samuel", skill: "Whistling" },
    { id: 1, name: "Samuel", skill: "Origami" },
    { id: 2, name: "Marco", skill: "Cooking" },
    { id: 2, name: "Marco", skill: "Painting" },
    { id: 2, name: "Marco", skill: "Skateboarding" },
    { id: 2, name: "Marco", skill: "Singing" },
    { id: 2, name: "Marco", skill: "Chess" },
    { id: 3, name: "Giulia", skill: "Dancing" },
    { id: 3, name: "Giulia", skill: "Photography" },
    { id: 3, name: "Giulia", skill: "Yoga" },
    { id: 3, name: "Giulia", skill: "Knitting" },
    { id: 3, name: "Giulia", skill: "Surfing" },
    { id: 4, name: "Luca", skill: "Guitar playing" },
    { id: 4, name: "Luca", skill: "Climbing" },
    { id: 4, name: "Luca", skill: "Magic tricks" },
    { id: 4, name: "Luca", skill: "Coding" },
    { id: 4, name: "Luca", skill: "Drawing" },
    { id: 5, name: "Sara", skill: "Swimming" },
    { id: 5, name: "Sara", skill: "Public speaking" },
    { id: 5, name: "Sara", skill: "Baking" },
    { id: 5, name: "Sara", skill: "Gardening" },
    { id: 5, name: "Sara", skill: "Card tricks" },
    { id: 6, name: "Andrea", skill: "Running" },
    { id: 6, name: "Andrea", skill: "Chess" },
    { id: 6, name: "Andrea", skill: "Pottery" },
    { id: 6, name: "Andrea", skill: "Whittling" },
    { id: 6, name: "Andrea", skill: "Juggling fire" },
];

function groupBy(arr) {

    let lastEl = null;
    let groups = [];
    for (let i = 0; i < arr.length; i++) {
        const current = arr[i];

        if (i === 0) { // Sono nel primo elemento dell'array
            lastEl = current;
            groups = [lastEl];
        } else { // Sono dopo il primo elemento
            if (current.id === lastEl.id) { // Se l'elemento corrente ha il solito valore del gruppo
                groups.push(current); // Inserisco l'elemento nel gruppo
            } else { // Se l'elemento ha un valore diverso, il mio gruppo è finito

                // Farò qualcosa con gli elementi del gruppo
                const first = groups[0];
                const skills = groups.map(row => {
                    return row.skill;
                });
                const finalObj = {
                    ...first,
                    skills
                }
                delete(finalObj.skill);
                console.log(finalObj);
                


                lastEl = current;
                groups = [lastEl];
            }
        }
    }

    if (groups.length !== 0) {
        // Farò qualcosa con gli elementi del gruppo
        const first = groups[0];
        const skills = groups.map(row => {
            return row.skill;
        });
        const finalObj = {
            ...first,
            skills
        }
        delete(finalObj.skill);
        console.log(finalObj);
    }
}

groupBy(arr1);