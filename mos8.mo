package mos8
  model ventilator1
    Modelica.Electrical.Analog.Basic.Ground ground1 annotation(Placement(visible = true, transformation(origin = {-52, -38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Basic.Inductor inductor1(L = 1) annotation(Placement(visible = true, transformation(origin = {-22, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Sine sine1 annotation(Placement(visible = true, transformation(origin = {-94, 82}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Sources.SignalVoltage signalVoltage1 annotation(Placement(visible = true, transformation(origin = {-60, 58}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Electrical.Analog.Basic.Capacitor capacitor1(C = 1) annotation(Placement(visible = true, transformation(origin = {-20, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Electrical.Analog.Basic.Resistor resistor1(R = 1) annotation(Placement(visible = true, transformation(origin = {20, 74}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.TransferFunction transferFunction1(b = {1}, a = {1, 1, 1}) annotation(Placement(visible = true, transformation(origin = {-52, -76}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(sine1.y, transferFunction1.u) annotation(Line(points = {{-83, 82}, {-78, 82}, {-78, -76}, {-64, -76}, {-64, -76}}, color = {0, 0, 127}));
    connect(inductor1.p, signalVoltage1.p) annotation(Line(points = {{-32, 70}, {-60, 70}, {-60, 68}, {-60, 68}}, color = {0, 0, 255}));
    connect(resistor1.p, inductor1.n) annotation(Line(points = {{10, 74}, {-12, 74}, {-12, 70}, {-12, 70}}, color = {0, 0, 255}));
    connect(capacitor1.p, resistor1.n) annotation(Line(points = {{-10, -30}, {30, -30}, {30, 74}}, color = {0, 0, 255}));
    connect(ground1.p, capacitor1.n) annotation(Line(points = {{-52, -28}, {-30, -28}, {-30, -30}, {-30, -30}}, color = {0, 0, 255}));
    connect(signalVoltage1.n, ground1.p) annotation(Line(points = {{-60, 48}, {-52, 48}, {-52, -28}, {-52, -28}}, color = {0, 0, 255}));
    connect(sine1.y, signalVoltage1.v) annotation(Line(points = {{-83, 82}, {-53, 82}, {-53, 58}}, color = {0, 0, 127}));
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
  end ventilator1;

  model test
    Modelica.Electrical.Analog.Basic.Ground ground1 annotation(Placement(visible = true, transformation(origin = {-48, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Basic.Inductor inductor1(L = 1) annotation(Placement(visible = true, transformation(origin = {-12, 48}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Electrical.Analog.Basic.Resistor resistor1(R = 1) annotation(Placement(visible = true, transformation(origin = {-12, 6}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Electrical.Analog.Basic.Capacitor capacitor1(C = 1) annotation(Placement(visible = true, transformation(origin = {-12, -40}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Continuous.TransferFunction transferFunction1(b = {1}, a = {1, 1, 1}) annotation(Placement(visible = true, transformation(origin = {30, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Sources.SignalVoltage signalVoltage1 annotation(Placement(visible = true, transformation(origin = {-64, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Step step1(startTime = 1) annotation(Placement(visible = true, transformation(origin = {-84, 86}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(step1.y, transferFunction1.u) annotation(Line(points = {{-73, 86}, {10, 86}, {10, 10}, {18, 10}, {18, 10}}, color = {0, 0, 127}));
    connect(signalVoltage1.v, step1.y) annotation(Line(points = {{-64, 65}, {-72, 65}, {-72, 86}, {-72, 86}}, color = {0, 0, 127}));
    connect(signalVoltage1.p, inductor1.p) annotation(Line(points = {{-74, 58}, {-12, 58}, {-12, 60}, {-12, 60}}, color = {0, 0, 255}));
    connect(signalVoltage1.n, ground1.p) annotation(Line(points = {{-54, 58}, {-48, 58}, {-48, -50}, {-48, -50}, {-48, -50}}, color = {0, 0, 255}));
    connect(capacitor1.p, resistor1.n) annotation(Line(points = {{-12, -30}, {-12, -4}}, color = {0, 0, 255}));
    connect(ground1.p, capacitor1.n) annotation(Line(points = {{-48, -50}, {-12, -50}}, color = {0, 0, 255}));
    connect(resistor1.p, inductor1.n) annotation(Line(points = {{-12, 16}, {-12, 16}, {-12, 38}, {-12, 38}}, color = {0, 0, 255}));
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
  end test;
  annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
end mos8;