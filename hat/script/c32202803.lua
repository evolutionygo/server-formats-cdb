--武神器－タルタ
--Bujingi Wolf
function c32202803.initial_effect(c)
	--Cannot be destroyed
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c32202803.indtg)
	e1:SetValue(1)
	c:RegisterEffect(e1)
end
function c32202803.indtg(e,c)
	return c~=e:GetHandler() and c:IsRace(RACES_BEAST_BWARRIOR_WINGB)
end