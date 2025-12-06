job(technician, eleuterio).
job(technician, juvenaldo).
job(analyst, leonilde).
job(analyst, marciliano).
job(engineer, osvaldo).
job(engineer, porfirio).
job(engineer, reginaldo).
job(supervisor, sisnando).
job(chief_supervisor, gertrudes).
job(secretary, felismina).
job(director, asdrubal).
supervised_by(technician, engineer).
supervised_by(engineer, supervisor).
supervised_by(analyst, supervisor).
supervised_by(supervisor, chief_supervisor).
supervised_by(chief_supervisor, director).
supervised_by(secretary, director).

supervises(X, Y) :- job(_R1, X), job(_R2, Y),
                    supervised_by(_R2, _R1).

same_supervisor_job(X, Y) :- job(_JX, X), job(_JY, Y),
                             supervised_by(_JX, R),
                             supervised_by(_JY, R),
                             X \= Y.

supervises_more_than_one_job(X) :- job(_J, X),
                                   supervised_by(_R1, _J),
                                   supervised_by(_R2, _J),
                                   _R1 \= _R2.

supervises_supervisor(X, Y) :- job(_J1, X), job(_J2, Y),
                               supervised_by(_J2, _S),
                               supervised_by(_S, _J1),
                               _J1 \= _J2.
