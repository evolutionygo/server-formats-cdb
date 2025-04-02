--マグネット・フォース (Anime)
--Magnet Force (Anime)
function c511000302.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000302.target)
	c:RegisterEffect(e1)
	--Remain field
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_REMAIN_FIELD)
	c:RegisterEffect(e2)
	--Redirect
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringc511000302(c511000302,0))
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_CHAINING)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCondition(c511000302.redirectCon)
	e3:SetTarget(c511000302.redirectTg)
	e3:SetOperation(c511000302.redirectOp)
	c:RegisterEffect(e3)
end
function c511000302.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:IsHasType(EFFECT_TYPE_ACTIVATE) end
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EVENT_TURN_END)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_SZONE)
	e1:SetOperation(function() Duel.SendtoGrave(c,REASON_RULE) end)
	e1:SetReset(RESET_EVENT|RESETS_STANDARD|RESET_PHASE|PHASE_END)
	c:RegisterEffect(e1)
	local res,teg,tep,tev,tre,tr,trp=Duel.CheckEvent(EVENT_CHAINING,true)
	if res and c511000302.redirectCon(e,tp,teg,tep,tev,tre,tr,trp) and c511000302.redirectTg(e,tp,teg,tep,tev,tre,tr,trp,0)
		and Duel.SelectEffectYesNo(tp,c) then
		e:SetProperty(EFFECT_FLAG_CARD_TARGET)
		c511000302.redirectTg(e,tp,teg,tep,tev,tre,tr,trp,1)
		e:SetOperation(c511000302.redirectOp)
	else
		e:SetProperty(0)
		e:SetOperation(nil)
	end
end
function c511000302.filter(c,p)
	return c:IsFaceup() and c:IsRace(RACE_MACHINE+RACE_ROCK) and c:IsControler(p) and c:IsLocation(LOCATION_MZONE)
end
function c511000302.redirectCon(e,tp,eg,ep,ev,re,r,rp)
	if rp==tp or not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	return g:IsExists(c511000302.filter,1,nil,tp)
end
function c511000302.redirectTg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.IsExistingTarget(nil,tp,0,LOCATION_MZONE,Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS):FilterCount(c511000302.filter,nil,tp),nil) end
	local tg=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	local g=tg:Filter(c511000302.filter,nil,tp)
	local g2=(tg-g):KeepAlive()
	e:SetLabelObject(g2)
	g2:ForEach(function(c) c:CreateEffectRelation(e) end)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,nil,tp,0,LOCATION_MZONE,#g,#g,nil)
end
function c511000302.redirectOp(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetTargetCards(e)
	local g=e:GetLabelObject():Filter(Card.IsRelateToEffect,nil,e)
	Duel.ChangeTargetCard(ev+(e:IsHasType(EFFECT_TYPE_ACTIVATE) and 1 or 0),tg+g)
end