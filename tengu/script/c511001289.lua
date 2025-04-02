--月光舞猫姫 (Anime)
--Lunalight Cat Dancer (Anime)
function c511001289.initial_effect(c)
	--fustion material
	aux.AddFusionProcCode2N(c,true,true,aux.FilterBoolFunction(Card.IsSetCard,0xdf),2)
	c:EnableReviveLimit()
	--attack
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc511001289(c511001289,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
	e1:SetCountLimit(1)
	e1:SetCost(c511001289.cost)
	e1:SetOperation(c511001289.operation)
	c:RegisterEffect(e1)
end
c511001289.listed_series={0xdf}
c511001289.material_setcode=0xdf
function c511001289.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroupCost(tp,Card.IsSetCard,1,false,nil,e:GetHandler(),0xdf) end
	local g=Duel.SelectReleaseGroupCost(tp,Card.IsSetCard,1,1,false,nil,e:GetHandler(),0xdf)
	Duel.Release(g,REASON_COST)
end
function c511001289.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		--attack
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_ATTACK_ALL)
		e1:SetValue(2)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		c:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_FIELD)
		e2:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
		e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetTargetRange(0,LOCATION_MZONE)
		e2:SetRange(LOCATION_MZONE)
		e2:SetTarget(c511001289.indtg)
		e2:SetValue(c511001289.indct)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD)
		c:RegisterEffect(e2)
	end
end
function c511001289.indtg(e,c)
	return c:GetReasonCard()==e:GetHandler()
end
function c511001289.indct(e,re,r,rp,c)
	if (r&REASON_BATTLE)~=0 then
		return 1
	else return 0 end
end