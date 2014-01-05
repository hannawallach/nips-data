load data/nips_1-17.mat
docs = full(counts);

unix(['if [ -e data/docs ]; then rm -r data/docs; fi']);

for d=1:size(docs, 2)

  name=['data/docs/' docs_names{d}];

  unix(['mkdir -p ' name]);
  unix(['rmdir ' name]);

  fid=fopen(name, 'w');

  for w=1:size(docs, 1)
    if docs(w, d) > 0
      for n=1:docs(w, d)
        fprintf(fid, '%s\n', words{w});
      end
    end
  end

  fclose(fid);
end

quit;
