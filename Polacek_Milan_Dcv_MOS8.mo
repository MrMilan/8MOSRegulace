package MOS8
  connector pq
    Real p;
    flow Real q;
    annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(origin = {-1, 2}, fillPattern = FillPattern.Solid, extent = {{-95, 94}, {95, -94}})}));
  end pq;

  model tlak
    pq pq1 annotation(Placement(visible = true, transformation(origin = {90, -92}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {90, -92}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    parameter Real p;
  equation
    pq1.p = p;
    annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(origin = {-8, 5}, extent = {{-88, 85}, {88, -85}}), Text(origin = {-11, 12}, extent = {{-69, 26}, {69, -26}}, textString = "P_%name")}));
  end tlak;

  model tok
    pq pq1 annotation(Placement(visible = true, transformation(origin = {90, -92}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {90, -92}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput u annotation(Placement(visible = true, transformation(origin = {-88, 72}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-78, 76}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  equation
    pq1.q = -u;
    annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Text(origin = {3, 2}, extent = {{-75, -42}, {75, 42}}, textString = "Q_%name"), Ellipse(origin = {6, -3}, lineColor = {170, 0, 127}, lineThickness = 2, extent = {{-86, 63}, {86, -63}}, endAngle = 360)}));
  end tok;

  model tank
    parameter Real roLiquid = 1000;
    parameter Real areaBase = 1;
    parameter Real gravit = 10;
    Real volume;
    pq pqIn annotation(Placement(visible = true, transformation(origin = {-88, -64}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-88, -64}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    pq pqOut annotation(Placement(visible = true, transformation(origin = {92, -66}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {88, -62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput height annotation(Placement(visible = true, transformation(origin = {84, 84}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {80, 78}, extent = {{-22, -22}, {22, 22}}, rotation = 0)));
  equation
    der(volume) = pqIn.q + pqOut.q;
    roLiquid * gravit * height = pqIn.p;
    pqIn.p = pqOut.p;
    volume = height * areaBase;
    annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(origin = {-6, 10}, fillColor = {0, 85, 255}, fillPattern = FillPattern.Horizontal, extent = {{-60, 70}, {64, -58}}), Text(origin = {1, -68}, extent = {{-65, -24}, {65, 24}}, textString = "%name")}));
  end tank;

  model ventil
    Modelica.Blocks.Interfaces.RealInput u annotation(Placement(visible = true, transformation(origin = {-4, 74}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {1, 45}, extent = {{-55, -55}, {55, 55}}, rotation = -90)));
    pq pqIn annotation(Placement(visible = true, transformation(origin = {-90, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-90, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    pq pqOut annotation(Placement(visible = true, transformation(origin = {90, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {90, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Real q;
    Boolean on;
  equation
    pqIn.q + pqOut.q = 0;
    pqIn.q = q;
    on = u >= 0;
    if on then
      q = u;
    else
      q = 0;
    end if;
    annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Polygon(origin = {-4.00007, -12}, points = {{-75.9999, 70}, {-75.9999, -68}, {84.0001, 70}, {84.0001, -68}, {-75.9999, 70}})}));
  end ventil;

  model Regulator
    parameter Real P;
    parameter Real I;
    parameter Real D;
    Real Iinter;
    Real error;
    Modelica.Blocks.Interfaces.RealInput height annotation(Placement(visible = true, transformation(origin = {-90, -30}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-61, -59}, extent = {{-39, -39}, {39, 39}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput Referention annotation(Placement(visible = true, transformation(origin = {-86, 82}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-60, 60}, extent = {{-40, -40}, {40, 40}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y annotation(Placement(visible = true, transformation(origin = {42, 84}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {60, 60}, extent = {{-38, -38}, {38, 38}}, rotation = 0)));
  equation
    error = height - Referention;
    y = P * error + Iinter + D * der(error);
    der(Iinter) = I * error;
    annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Text(origin = {-20, 85}, extent = {{-32, -19}, {32, 19}}, textString = "Ref"), Text(origin = {-33, -25}, extent = {{-37, 17}, {37, -17}}, textString = "height"), Text(origin = {9, -108}, extent = {{-95, -36}, {95, 36}}, textString = "%name")}));
  end Regulator;

  model halfMeter
    Modelica.Blocks.Sources.Ramp ramp1(duration = 0.01, height = -0.25, offset = 0.5, startTime = 10) annotation(Placement(visible = true, transformation(origin = {-56, 82}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Step step1(height = 0.1, startTime = 20, offset = 0.1) annotation(Placement(visible = true, transformation(origin = {-56, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    tok tok1 annotation(Placement(visible = true, transformation(origin = {-12, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Regulator regulator1(P = 8, I = 5, D = 0.3) annotation(Placement(visible = true, transformation(origin = {22, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    tlak tlak1 annotation(Placement(visible = true, transformation(origin = {84, -14}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    ventil ventil1 annotation(Placement(visible = true, transformation(origin = {54, -18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    tank tank1 annotation(Placement(visible = true, transformation(origin = {20, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(tank1.pqOut, ventil1.pqIn) annotation(Line(points = {{29, -22}, {40, -22}, {40, -18}, {45, -18}}));
    connect(tank1.height, regulator1.height) annotation(Line(points = {{28, -8}, {40, -8}, {40, 10}, {-4, 10}, {-4, 28}, {16, 28}}, color = {0, 0, 127}));
    connect(tank1.pqIn, tok1.pq1) annotation(Line(points = {{11, -22}, {8, -22}, {8, -25}, {-3, -25}}));
    connect(ventil1.pqOut, tlak1.pq1) annotation(Line(points = {{63, -18}, {68, -18}, {68, -24}, {74, -24}, {74, -24}}));
    connect(regulator1.y, ventil1.u) annotation(Line(points = {{28, 40}, {54, 40}, {54, -10}, {54, -10}}, color = {0, 0, 127}));
    connect(ramp1.y, regulator1.Referention) annotation(Line(points = {{-45, 82}, {-28, 82}, {-28, 40}, {14, 40}, {14, 40}}, color = {0, 0, 127}));
    connect(step1.y, tok1.u) annotation(Line(points = {{-45, -22}, {-36, -22}, {-36, -8}, {-20, -8}, {-20, -8}}, color = {0, 0, 127}));
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
  end halfMeter;

  model AntiWRegulator
    parameter Real P;
    parameter Real I;
    parameter Real D;
    Real Iinter;
    Real error;
    Modelica.Blocks.Interfaces.RealInput height annotation(Placement(visible = true, transformation(origin = {-90, -30}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-61, -59}, extent = {{-39, -39}, {39, 39}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput Referention annotation(Placement(visible = true, transformation(origin = {-86, 82}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-60, 60}, extent = {{-40, -40}, {40, 40}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y annotation(Placement(visible = true, transformation(origin = {42, 84}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {60, 60}, extent = {{-38, -38}, {38, 38}}, rotation = 0)));
  equation
    error = height - Referention;
    y = P * error + Iinter + D * der(error);
    if y < 0 then
      der(Iinter) = 0;
    else
      der(Iinter) = I * error;
    end if;
    annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(origin = {0, 1}, fillColor = {255, 170, 0}, fillPattern = FillPattern.Solid, extent = {{-100, 101}, {100, -101}}), Text(origin = {-20, 85}, extent = {{-32, -19}, {32, 19}}, textString = "Ref"), Text(origin = {-33, -25}, extent = {{-37, 17}, {37, -17}}, textString = "height"), Text(origin = {9, -108}, extent = {{-95, -36}, {95, 36}}, textString = "%name")}));
  end AntiWRegulator;

  model AntiHalfMeter
    Modelica.Blocks.Sources.Ramp ramp1(duration = 0.01, height = -0.25, offset = 0.5, startTime = 10) annotation(Placement(visible = true, transformation(origin = {-56, 82}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Step step1(height = 0.1, startTime = 20, offset = 0.1) annotation(Placement(visible = true, transformation(origin = {-56, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    tok tok1 annotation(Placement(visible = true, transformation(origin = {-12, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    tlak tlak1 annotation(Placement(visible = true, transformation(origin = {84, -14}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    ventil ventil1 annotation(Placement(visible = true, transformation(origin = {54, -18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AntiWRegulator antiWRegulator1(P = 8, I = 3, D = 0.3) annotation(Placement(visible = true, transformation(origin = {18, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    tank tank1 annotation(Placement(visible = true, transformation(origin = {23, -13}, extent = {{-13, -13}, {13, 13}}, rotation = 0)));
  equation
    connect(antiWRegulator1.y, ventil1.u) annotation(Line(points = {{24, 44}, {54, 44}, {54, -12}, {54, -12}}, color = {0, 0, 127}));
    connect(ramp1.y, antiWRegulator1.Referention) annotation(Line(points = {{-45, 82}, {-24, 82}, {-24, 44}, {12, 44}, {12, 44}}, color = {0, 0, 127}));
    connect(tank1.height, antiWRegulator1.height) annotation(Line(points = {{33, -3}, {33, 12}, {-8, 12}, {-8, 30}, {10, 30}, {10, 30}}, color = {0, 0, 127}));
    connect(tank1.pqIn, tok1.pq1) annotation(Line(points = {{12, -21}, {8, -21}, {8, -25}, {-3, -25}}));
    connect(tank1.pqOut, ventil1.pqIn) annotation(Line(points = {{34, -21}, {40, -21}, {40, -18}, {45, -18}}));
    connect(ventil1.pqOut, tlak1.pq1) annotation(Line(points = {{63, -18}, {68, -18}, {68, -24}, {74, -24}, {74, -24}}));
    connect(step1.y, tok1.u) annotation(Line(points = {{-45, -22}, {-36, -22}, {-36, -8}, {-20, -8}, {-20, -8}}, color = {0, 0, 127}));
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
  end AntiHalfMeter;
  annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), uses(Modelica(version = "2.2.2")));
end MOS8;