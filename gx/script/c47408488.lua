--宝玉の樹
--Crystal Tree
function c47408488.initial_effect(c)
	c:EnableCounterPermit(0x6)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Place 1 Crystal Counter on this card
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_MOVE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c47408488.ctcon1)
	e2:SetOperation(c47408488.ctop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_CHAIN_SOLVED)
	e3:SetCondition(c47408488.ctcon2)
	c:RegisterEffect(e3)
	--Place "Crystal Beast" monsters to your Spell/Trap Zone
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringc47408488(c47408488,1))
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCost(c47408488.plcost)
	e4:SetTarget(c47408488.pltg)
	e4:SetOperation(c47408488.plop)
	c:RegisterEffect(e4)
end
c47408488.listed_series={0x1034}
c47408488.counter_place_list={0x6}
function c47408488.ctfilter(c)
	return c:IsLocation(LOCATION_SZONE) and not c:IsPreviousLocation(LOCATION_SZONE) and c:IsSetCard(0x1034) and c:IsFaceup()
		and c:IsOriginalType(TYPE_MONSTER)
end
function c47408488.ctcon1(e,tp,eg,ep,ev,re,r,rp)
	if not eg:IsExists(c47408488.ctfilter,1,nil) then return end
	if Duel.GetCurrentChain()>0 then
		e:GetHandler():RegisterFlagEffect(c47408488,RESET_EVENT+RESETS_STANDARD+RESET_CHAIN,0,1)
		return false
	end
	return true
end
function c47408488.ctcon2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:GetFlagEffect(c47408488)>0 then
		c:ResetFlagEffect(c47408488)
		return true
	else
		return false
	end
end
function c47408488.ctop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():AddCounter(0x6,1)
end
function c47408488.plcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToGraveAsCost() end
	e:SetLabel(c:GetCounter(0x6))
	Duel.SendtoGrave(c,REASON_COST)
end
function c47408488.plfilter(c)
	return c:IsSetCard(0x1034) and c:IsMonster() and not c:IsForbc47408488den()
end
function c47408488.pltg(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=e:GetHandler():GetCounter(0x6)
	if chk==0 then return ct>0 and Duel.GetLocationCount(tp,LOCATION_SZONE)>=ct-1
		and Duel.IsExistingMatchingCard(c47408488.plfilter,tp,LOCATION_DECK,0,ct,nil) end
end
function c47408488.plop(e,tp,eg,ep,ev,re,r,rp)
	local ct=e:GetLabel()
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<ct then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
	local g=Duel.SelectMatchingCard(tp,c47408488.plfilter,tp,LOCATION_DECK,0,ct,ct,nil)
	if #g==0 then return end
	local c=e:GetHandler()
	for tc in g:Iter() do
		Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		--Treat it as a Continuous Spell
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_TYPE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_TURN_SET)
		e1:SetValue(TYPE_SPELL+TYPE_CONTINUOUS)
		tc:RegisterEffect(e1)
	end
end