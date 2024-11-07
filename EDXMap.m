classdef EDXMap
    properties
        X {mustBeNumeric}
        Y {mustBeNumeric}
        numElems {mustBeNumeric}
        imageShape {mustBeNumeric}
        elements
        elemPeaks
        file
        windowIntervalData
        XCells
        YCells
        XStep
        YStep
    end
    methods

        function obj = setupMap(obj)
            obj.XCells = h5read(obj.file, '/1/EDS/Header/X Cells');
            obj.YCells = h5read(obj.file, '/1/EDS/Header/Y Cells');
            obj.XStep = h5read(obj.file, '/1/EDS/Header/X Step');
            obj.YStep = h5read(obj.file, '/1/EDS/Header/Y Step');
            obj.imageShape = [obj.XCells, obj.YCells];

            obj.X = reshape(h5read(obj.file, '/1/EDS/Data/X'), obj.imageShape)';
            obj.Y = reshape(h5read(obj.file, '/1/EDS/Data/Y'), obj.imageShape)';
        end

        function obj = getElementInfo(obj)
            windInt = h5info(obj.file, "/1/EDS/Data/Window Integral");
            elems = windInt.Datasets;
            obj.numElems = length(elems);
            obj.elemPeaks = string({elems.Name})';
            obj.elements = extractBefore(obj.elemPeaks, ' ');
        end

        function obj = getWindowInterval(obj)
            obj = getElementInfo(obj);
            for i = 1:obj.numElems
                currElement = obj.elements(i);
                currPeak = obj.elemPeaks(i);
                currData = h5read(obj.file, strjoin(["/1/EDS/Data/Window Integral", currPeak], '/'));
                obj.windowIntervalData.(currElement) = reshape(currData, obj.imageShape)';
            end
        end

        function plotMap(obj, element)
            figure;
            data = obj.windowIntervalData.(element);
            data = imgaussfilt(data, 5);
            imagesc(data); axis image;
            colormap magma
        end

    end
end