--音響戦士ピアーノ
--Symphonic Warrior Piaano
function c31826057.initial_effect(c)
	--attribute change
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc31826057(c31826057,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c31826057.target(LOCATION_MZONE))
	e1:SetOperation(c31826057.operation)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc31826057(c31826057,0))
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c31826057.target(0))
	e2:SetOperation(c31826057.operation)
	c:RegisterEffect(e2)
end
c31826057.listed_series={0x1066}
function c31826057.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x1066)
end
function c31826057.target(oppo)
	return function (e,tp,eg,ep,ev,re,r,rp,chk,chkc)
		if chkc then return chkc:IsLocation(LOCATION_MZONE) and (oppo==0 or chkc:IsControler(tp)) and c31826057.filter(chkc) and chkc:IsDifferentRace(e:GetLabel()) end
		if chk==0 then return Duel.IsExistingTarget(c31826057.filter,tp,LOCATION_MZONE,oppo,1,nil) end
		local g=Duel.GetMatchingGroup(aux.AND(c31826057.filter,Card.IsCanBeEffectTarget),tp,LOCATION_MZONE,oppo,nil,e)
		local rc=Duel.AnnounceAnotherRace(g,tp)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
		local sel=g:FilterSelect(tp,Card.IsDifferentRace,1,1,nil,rc)
		Duel.SetTargetCard(sel)
		e:SetLabel(rc)
	end
end
function c31826057.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_RACE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(e:GetLabel())
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
	end
end