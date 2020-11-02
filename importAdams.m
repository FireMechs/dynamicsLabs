function importAdams()
    %QAf = fopen('Question_A','rt');
    QBf = fopen('Question_B', 'rt');
    %QA = textscan(QAf, '%f %f','HeaderLines', 7);
    QB = textscan(QBf,'%f %f','HeaderLines', 7)
    %cellplot(QA);
    %disp(QA{1});
    %cellplot(QB); 
    disp(QB{1});
    %fclose(QAf);
    fclose(QBf);
end