--マジック・クロニクル
--Spell Chronicle
function c74402414.initial_effect(c)
	c:EnableCounterPermit(0x25)
	local g=Group.CreateGroup()
	g:KeepAlive()
	--Activate
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	e0:SetCost(c74402414.cost)
	e0:SetTarget(c74402414.target)
	e0:SetOperation(c74402414.activate)
	e0:SetLabelObject(g)
	c:RegisterEffect(e0)
	--Add counters
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_SZONE)
	e1:SetOperation(aux.chainreg)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetCode(EVENT_CHAIN_SOLVED)
	e2:SetRange(LOCATION_SZONE)
	e2:SetOperation(c74402414.ctop)
	c:RegisterEffect(e2)
	--Add cards back to hand
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringc74402414(c74402414,0))
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCost(c74402414.thcost)
	e3:SetTarget(c74402414.thtg)
	e3:SetOperation(c74402414.thop)
	e3:SetLabelObject(g)
	c:RegisterEffect(e3)
	--Register before leaving
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_LEAVE_FIELD_P)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e4:SetOperation(c74402414.checkop)
	e4:SetLabelObject(g)
	c:RegisterEffect(e4)
	--Inflict damage
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e5:SetCode(EVENT_LEAVE_FIELD)
	e5:SetOperation(c74402414.damop)
	e5:SetLabelObject(e4)
	c:RegisterEffect(e5)
end
c74402414.counter_place_list={0x25}
function c74402414.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local hg=Duel.GetFieldGroup(tp,LOCATION_HAND,0):Filter(aux.TRUE,e:GetHandler())
	if chk==0 then return #hg>0 and hg:FilterCount(Card.IsAbleToGraveAsCost,nil)==#hg end
	Duel.SendtoGrave(hg,REASON_COST)
end
function c74402414.filter(c)
	return c:IsSpellTrap() and c:IsAbleToRemove()
end
function c74402414.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c74402414.filter,tp,LOCATION_DECK,0,5,nil) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,5,tp,LOCATION_DECK)
end
function c74402414.activate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=Duel.GetMatchingGroup(c74402414.filter,tp,LOCATION_DECK,0,nil)
	if #g<5 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local rg=g:Select(tp,5,5,nil)
	Duel.Remove(rg,POS_FACEUP,REASON_EFFECT)
	for tc in aux.Next(rg) do
		tc:RegisterFlagEffect(c74402414,RESET_EVENT+RESETS_STANDARD,0,0)
	end
	e:GetLabelObject():Clear()
	e:GetLabelObject():Merge(rg)
end
function c74402414.ctop(e,tp,eg,ep,ev,re,r,rp)
	if rp==1-tp and re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:IsActiveType(TYPE_SPELL) and e:GetHandler():GetFlagEffect(1)>0 then
		e:GetHandler():AddCounter(0x25,1)
	end
end
function c74402414.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanRemoveCounter(tp,0x25,2,REASON_COST) end
	e:GetHandler():RemoveCounter(tp,0x25,2,REASON_COST)
end
function c74402414.thfilter(c)
	return c:GetFlagEffect(c74402414)~=0 and c:IsAbleToHand()
end
function c74402414.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return e:GetLabelObject():IsContains(chkc) and c74402414.thfilter(chkc) end
	if chk==0 then return e:GetLabelObject():IsExists(c74402414.thfilter,1,nil) end
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_ATOHAND)
	local g=e:GetLabelObject():FilterSelect(1-tp,c74402414.thfilter,1,1,nil)
	e:GetLabelObject():Sub(g)
	Duel.SetTargetCard(g)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_REMOVED)
end
function c74402414.thop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end
function c74402414.dfilter(c)
	return c:GetFlagEffect(c74402414)~=0
end
function c74402414.checkop(e,tp,eg,ep,ev,re,r,rp)
	local ct=e:GetLabelObject():FilterCount(c74402414.dfilter,nil)
	local c=e:GetHandler()
	if c:IsDisabled() or not c:IsStatus(STATUS_EFFECT_ENABLED) or ct==0 then
		e:SetLabel(0)
	else
		e:SetLabel(ct)
	end
end
function c74402414.damop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ct=e:GetLabelObject():GetLabel()
	if ct>0 and c:GetPreviousControler()==tp then
		Duel.Damage(tp,ct*500,REASON_EFFECT)
	end
end