const fs = require('fs');

const input = fs.readFileSync(`${__dirname}/input.txt`, 'utf-8').split('\n').map(Number);
let res1 = 0;
const sumTriples = [];
input.forEach((n, index, arr) => {
    if (arr[index+1] && arr[index+2]) {
        sumTriples.push(n + arr[index + 1] + arr[index + 2]);
    }

    if (arr[index-1] && n > arr[index-1]) res1++;
});
let res2 = 0;
sumTriples.forEach((n, index) => {
    if (sumTriples[index - 1] && n > sumTriples[index - 1]) res2++;
});
console.log(res1);
console.log(res2);
