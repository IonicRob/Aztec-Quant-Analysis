classdef SEMap
    properties
        X {mustBeNumeric}
        Y {mustBeNumeric}
        numElems {mustBeNumeric}
        imageShape {mustBeNumeric}
        file
        XCells
        YCells
        XStep
        YStep
        SE
    end
    methods

        function obj = setupMap(obj)
            obj.XCells = h5read(obj.file, '/1/Electron Image/Header/X Cells');
            obj.YCells = h5read(obj.file, '/1/Electron Image/Header/Y Cells');
            obj.XStep = h5read(obj.file, '/1/Electron Image/Header/X Step');
            obj.YStep = h5read(obj.file, '/1/Electron Image/Header/Y Step');
            obj.imageShape = [obj.XCells, obj.YCells];
            obj.SE = reshape(h5read(obj.file, '/1/Electron Image/Data/SE/Electron Image 1'), obj.imageShape)'; 
        end
    end
end