function model=updateModel(model, indexS, indexA, s, r)
model(indexS, indexA, 1) = s;
model(indexS, indexA, 2) = r;
end